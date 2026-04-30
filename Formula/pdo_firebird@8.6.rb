# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/14624997bbb5dffa6b47dc5e9b2e16b22e1f5b54.tar.gz?commit=14624997bbb5dffa6b47dc5e9b2e16b22e1f5b54"
  version "8.6.0"
  sha256 "b00bdf793aec825cc04873db41c3dcca32b1f28c16aac3b22087c537befe6af8"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fa700697e1a77d90b9bdc9da4b51556007bad808592e165fe798c1979fcd31f8"
    sha256 cellar: :any,                 arm64_sequoia: "c761d92bc9a61969d35a3e7dcfc09b5899dacb42bb034b947f6b48f211ed482d"
    sha256 cellar: :any,                 arm64_sonoma:  "966c6f08b7a3f8c5f9591daa261aeca8be6a9c91fb03ca8f17c4f347f0f0c65c"
    sha256 cellar: :any,                 sonoma:        "f10cd4927004aa28ebbbc35679519b536a1e9786b4f123f653ac8a3bf18a15d3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0f1afa039bdd2ad1cd5729e7c10e5e7ca8252a586f3876f6fd72568ddf72a70e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "17086b3e689d9749d2a8a1ce4a13f706b66737ceab74686decf11b843227cf25"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
