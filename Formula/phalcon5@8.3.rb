# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.22.0.tgz"
  sha256 "da783fc9157cff533aa6f44f01134237fa1542c1310cbd06299340d4a6252979"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "2a66ed4849faadb77f0ba538260703ddbb4c5020e92459149271b9ce5c7d043d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "636efd896d2f8015addbababd0baa19c8c52dbc8776b6776e55a2b081fe5be2c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "4b123a01ff9e297ae66263b8c39c93d422a6051d9658cccdc296e2720dc9878a"
    sha256 cellar: :any,                 arm64_linux:       "a031ec2f60acbe7475c67f388ad7d4d4a2f150a593b507de5b710a009422e915"
    sha256 cellar: :any,                 x86_64_linux:      "ede69bc48cf9f398564bcf56d872f14cb909f75ad290bdc1a119508c1d086a16"
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
