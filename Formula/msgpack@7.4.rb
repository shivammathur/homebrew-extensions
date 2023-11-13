# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT74 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2f06c6bb32ba619b7bf657bcb37d54ae21fe676a2da73266e86823063255a0be"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4790daf0d5a930ddd0672ddc3707f7039d0422f71b4df23a52210c3ad5628055"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "289de2754af94a111e07628432116bf33255556f6ade53813e1c265c30a30d46"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "bdef1a7e649486154a69538e1ad20421aa45ca6d4eb56eab3df279dff588ad43"
    sha256 cellar: :any_skip_relocation, ventura:        "b282f9c9ec243c45d4db6bac903e483998473e29fac1fe082225a0f4faebe4db"
    sha256 cellar: :any_skip_relocation, monterey:       "2349976403e2aaa4e6859267a492c6b5ccfefa757bbee9322797d08dc2347bc5"
    sha256 cellar: :any_skip_relocation, big_sur:        "067546b855220909eb9333fde59fa4186ddc42c0f20bfee2a924e1ad0e251f3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "33262a54f44d8e85891acefa89bcc90c479f6eba849da9ae743dbb08b70f9dcc"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
