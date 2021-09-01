# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT81 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://github.com/msgpack/msgpack-php/archive/831b665e05007a820e841ba585e250d639986328.tar.gz"
  sha256 "4d20d70321eacf43634dea5103f1dc81820d6965a50ff8cfc6aff17df0fbea73"
  version "2.1.2"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "96b6f01e5c9c08b81aba6b04b5f60c167dfede459d9cb3f9372079dc17857749"
    sha256 cellar: :any_skip_relocation, big_sur:       "82cd6d2d43dfecc048aee95b8a57a502d4558c20b449ea114a16d9a87dff33e4"
    sha256 cellar: :any_skip_relocation, catalina:      "08fabc4df0f0ba6676f359fe1f2ab6817d612d8a30af860c68b522f0bf995d6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a33409ea07af7e54a6d05cf54bb3968dd0d98259703129e2aa1d1091a9f1d25"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
