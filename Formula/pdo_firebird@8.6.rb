# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/28dab5fafb18ef3757cd56639c3238c8ac8b1f9f.tar.gz?commit=28dab5fafb18ef3757cd56639c3238c8ac8b1f9f"
  version "8.6.0"
  sha256 "75a8d350649c19bd708e2582ffbfc2a6bcd845c2fbe89e7953aaf37e5bed4bcb"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any, arm64_tahoe:   "707bf9aad1b77383338ebee019074248018c7c606b59fe2f09cb3bf17d963cbd"
    sha256 cellar: :any, arm64_sequoia: "571583c122a2bdb7dd630c7b72895f919de3d5a74d67650afe6cb1f681ebe3ec"
    sha256 cellar: :any, arm64_sonoma:  "5d24a8ca75f6a66ad029ba5742c0690790d85c069895cc6f3fdf452383372fec"
    sha256 cellar: :any, sonoma:        "34da43126e1bf18ac2699b50b36596d5a0fc74d084b69c212daa33d9d963d942"
    sha256 cellar: :any, arm64_linux:   "f284e7f55a1d460b9827f9af392419de638fa7a23db45ca08c57f38024f97fa8"
    sha256 cellar: :any, x86_64_linux:  "5f9c1e1ad15ffb5a31e197300cc6bf34a00d02723ac5418a0b65d7756760c4e4"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
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
