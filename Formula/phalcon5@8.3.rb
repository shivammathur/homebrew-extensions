# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.2.tgz"
  sha256 "d16b250a1efe85b7083125731a5f664ac6bc16114e09da5f63fac085769cc48d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3aa8075097de7f8a7d09b7bc13d33db92ff0e3fd2822a889e4c60d465aa9d8b2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "77a97ecaf480363ed2f96fd8b3b00ea8abfaf60f3d004b804d22ca950fadfc38"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "11b536f81db640557c3023f1327ef869186c952a8bed4fed7496cbeb857343a1"
    sha256 cellar: :any_skip_relocation, sonoma:        "fd4635b33943456a00254d6cf790c7d90f36eef35785e84d0476bd9821a7a014"
    sha256 cellar: :any,                 arm64_linux:   "33705e6ea3e5dac5a34b98bd07070f6d64bfe647a75a2924ea27949418169b00"
    sha256 cellar: :any,                 x86_64_linux:  "290317a0f042569529f3a839c5cd22d483de1f0f936e906fc99d0946eb3a0b8a"
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
