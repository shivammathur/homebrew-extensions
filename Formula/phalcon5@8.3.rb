# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.0.tgz"
  sha256 "927caeda88334a33934d17b7d3b70ff46e0649e577f1339dc711bdb853290345"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5019c0d61a15e7f8740492cb56b0c4a1a8a1fba56d671b097611e5892b9c14fb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d38e0bcd215ad9955244cf522a5493c4d7eb5ed513a433e3b12150a11bc9e2cb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6a8241f4d31ed1b7af2b51395ef23e832d833c5a57bcaa7edb9761bbaf1ff79b"
    sha256 cellar: :any_skip_relocation, sonoma:        "21103c61304de4184348c6af27063d701a43424d816411f13efa67e5917a2a80"
    sha256 cellar: :any,                 arm64_linux:   "0b535126dc5574060925317328df745ddd5f390d4b8f9868e00829d515671009"
    sha256 cellar: :any,                 x86_64_linux:  "4fd641185e4e35b7950ecd6225cf7adce842d6764f2f85cf05dc1c1bdd72b8ad"
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
