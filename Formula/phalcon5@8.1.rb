# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.11.0.tgz"
  sha256 "c4d0e1659d82151ce8f0087ad9f2dfb7b0bd8bd19814526d424d010e24877601"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aadf58909f3cf80ea35410338d66abd34877caef91e033fed84646da7829a0a4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cbd000a358161eade71fd4e8a507e6acbdc58f33495be010a5c1e57ad38f9fa5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1a5299ba04c4e2d89ccd001f6e593e7f4f4291d67d2f4154df0a69b6d8b4c653"
    sha256 cellar: :any_skip_relocation, sonoma:        "47fa4f24cb57855f885ae3e3571615c89c33a670ebbaf1ec95f689233cb2374e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d30000be4f4aee59acda940cf627f5027047476fe62b3e6173720dc45c430cfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c0a2464a937286d2c916699787f6868133c5adf12f7f8618dcce80aa14085f9b"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
