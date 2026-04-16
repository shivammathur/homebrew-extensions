# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT81 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fb46896b34a15ff32f57ccd544a1ee82d33fd6e456f91fd9805f8a4a1ff5e0e8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1144d45df08e9748ae1bbb6e6ef67f1a63ce889f0e158befdfc2f9c3a6500de5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "77957f2e8664bd7917856f09dd6ca6cc1a031612dd3274f11545b99adfccbf82"
    sha256 cellar: :any_skip_relocation, sonoma:        "afff5dcd2c5da11afa6d62a11c2240585341fbf0587c5dc6670b2ef63fb94f9b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "772b26831d7336e99e7a7df12e0ece45aa7b66c1da168a69bd092e3fca474fa6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "54c123943f27d06ac14d175dbc10fc6cd262015d8997e01dd9e4b1b4673f6361"
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
