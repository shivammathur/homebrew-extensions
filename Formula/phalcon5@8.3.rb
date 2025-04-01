# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.1.tgz"
  sha256 "e2a7720c066e7c0d1be646d142634497672b64a4660cea4edb4bcdb2df59be8a"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9bb41920f85a78d2962acfefc045d2e685010ef10abc62aaba2c8a1c019935bd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "61cb0934cba4030017619fbf5126c29ece97773ac0c4352ad95f93756b977a0d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ec462d8523265b71ad7b162bd01df4b5a9c0a4bf27e9ee4796c2ca30f427eb2f"
    sha256 cellar: :any_skip_relocation, ventura:       "4ee9fe0cce49d6696c022fe0b8333584b77996c1363edfc97fb7b5f2f4c0a1f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb798123285f2c431998627fae7ed6ee873329ae619462e3d996f99bdb4a6fc1"
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
