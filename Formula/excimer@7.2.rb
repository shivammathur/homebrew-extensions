# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT72 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.5.tgz"
  sha256 "cf49acd81a918ea80af7be4c8085746b4b17ffe30df3421edd191f0919a46d1d"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2a5b4c65cf18b7996d3525272b7633b66d843fb429d544621f71c38ea3dea8b2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "062a1b42d58ed6fd6eb35871c23e0f06335f27eb77e5889345aa53b5ef938a0d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0772215936a57821214f86e564486a5922bf7bc0934a13539b8d02430be782a0"
    sha256 cellar: :any_skip_relocation, sonoma:        "6f47e1d453a96f6c50b92e33fa92b9d58336df8c236185010db674e14cd5503b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d030bd20f3724bfcbcee37c1e242544ed0b692dc365c13d26646520502d407ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb5c587e583a0404c1f4004f7f0e1da5c9c3004e939a2f289f2cf6231ea2dbdc"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
