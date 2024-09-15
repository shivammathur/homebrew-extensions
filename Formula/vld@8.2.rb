# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT82 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.18.0.tar.gz"
  sha256 "b6cd6165014bd8c1ddd8b473fc2e232a722c88226a52368c32555cc9cbfa71ed"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a9b809251c0531e1d505f6d75bf4cb5ddc5631a549719d44c2b02f2821fcdcd8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6b16639b64427a4baa80e815aa9909e924d6bfaec1cf3871ea720d3e86c9fe50"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "42bee283b517b2805318fc2b66073209157f6acc0c60f1363c9a36239c326c5d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2ce591f18eccfa6bd4a1f5540d23dc291affd1dacb7df3996797a620399d23aa"
    sha256 cellar: :any_skip_relocation, ventura:        "30dd685551ac9b7e33fea44052aa9ac480b401b3a6e35bcf0db6d297241bd1e6"
    sha256 cellar: :any_skip_relocation, monterey:       "716efbe9ea44918eed31e0c25cdafaa3509dcd8eb8e415b99e1a712780f24088"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3bd6a49fbb0bc2c35138aebd9a087fc683e0aaa4f1c5bc9c282ec7a1e2afd9cc"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
