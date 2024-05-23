# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.7.0.tgz"
  sha256 "1c82b5c4d7329229daa21f77006781e92b7603627e7a643a2ec0dbf87b6cc48e"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4c50687a4d33fe2d6a2de3a25f72a1ada65918a0c0554d15e2cb55dbb60c43ad"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "83cd34e0eab734c0f3a35bdaa391637975c8621966d916c36e90114fd171d73c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dfdfac281a8e7332a77d27a37ddc6f4a61e88a8ed04815679822e5eb4e45031a"
    sha256 cellar: :any_skip_relocation, ventura:        "3ed7a83e8f7f8567cbc735b43a7b75640dbbeadc6259b6838c115e05ac19e1bd"
    sha256 cellar: :any_skip_relocation, monterey:       "33af87ed306706289e5517c4ab1f818687fef19a377f67f00d30466f919239db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "89a32f23e65bb491a8835c2f8257309b4b3479e6ca5a9b9f46cae0e72397b50c"
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
