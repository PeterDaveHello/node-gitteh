path = require "path"
should = require "should"
gitteh = require "../lib/gitteh"
utils = require "./utils"
fixtures = require "./fixtures"

secondCommit = fixtures.testRepo.secondCommit

describe "Commit", ->
	repo = null
	commit = null

	describe "Using the test repo...", ->
		it "can find second commit (#{secondCommit.id})", (done) ->
			gitteh.openRepository fixtures.testRepo.path, (err, _repo) ->
				repo = _repo
				repo.commit secondCommit.id, (err, _commit) ->
					commit = _commit
					should.not.exist err
					commit.should.be.an.instanceof gitteh.Commit
					done()
	describe "The first project commit...", ->
		describe "#id", ->
			it "is correct", ->
				commit.id.should.be.equal secondCommit.id
			it "is immutable", -> utils.checkImmutable commit, "id"
		describe "#treeId", ->
			it "is correct", ->
				commit.treeId.should.be.equal secondCommit.tree
			it "is immutable", -> utils.checkImmutable commit, "treeId"
		describe "#message", ->
			it "is correct", ->
				commit.message.should.be.equal 
			it "is immutable", -> utils.checkImmutable commit, "message"
		describe "#parents", ->
			it "is correct", ->
				commit.parents.should.have.length 1
				commit.parents.should.include secondCommit.parent
		describe "#author", ->
			it "is valid", ->
				author = commit.author
				author.should.be.a "object"
				should.exist author.name
				should.exist author.email
				should.exist author.time
				should.exist author.offset
			it "is immutable", -> utils.checkImmutable commit, "author"
			describe "#name", ->
				it "is valid", ->
					commit.author.name.should.be.equal secondCommit.author.name
				it "is immutable", -> utils.checkImmutable commit.author, "name"
			describe "#email", ->
				it "is valid", ->
					commit.author.email.should.be.equal secondCommit.author.email
				it "is immutable", -> utils.checkImmutable commit.author, "email"
			describe "#time", ->
				it "is valid", ->
					commit.author.time.toUTCString().should.be.equal secondCommit.author.time
				it "is immutable", -> utils.checkImmutable commit.author, "time"
			describe "#offset", ->
				it "is valid", ->
					commit.author.offset.should.equal secondCommit.author.offset
				it "is immutable", -> utils.checkImmutable commit.author, "offset"
		describe "#committer", ->
			it "is valid", ->
				committer = commit.committer
				committer.should.be.a "object"
				should.exist committer.name
				should.exist committer.email
				should.exist committer.time
				should.exist committer.offset
			it "is immutable", -> utils.checkImmutable commit, "committer"
			describe "#name", ->
				it "is valid", ->
					commit.committer.name.should.be.equal secondCommit.author.name
				it "is immutable", -> utils.checkImmutable commit.committer, "name"
			describe "#email", ->
				it "is valid", ->
					commit.committer.email.should.be.equal secondCommit.author.email
				it "is immutable", -> utils.checkImmutable commit.committer, "email"
			describe "#time", ->
				it "is valid", ->
					commit.committer.time.toUTCString().should.be.equal secondCommit.author.time
				it "is immutable", -> utils.checkImmutable commit.committer, "time"
			describe "#offset", ->
				it "is valid", ->
					commit.committer.offset.should.equal secondCommit.author.offset
				it "is immutable", -> utils.checkImmutable commit.committer, "offset"
