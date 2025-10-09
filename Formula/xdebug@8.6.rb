# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/eeb4338afe11269635e272596841485474d7374f.tar.gz"
  sha256 "8499114ec7e270c108d9bc284ddd877e57d44ce3b465ecfde6a46c4381c97be2"
  version "3.4.5"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "34d89ee6b611284dbc52a1ab1f911eb8540dd13b3326db8b71b928574b284ed8"
    sha256                               arm64_sequoia: "4eed87c7e0acfc10a19094dc6c1d3472ec2e6cd258e810bf5a120c2393770dc8"
    sha256                               arm64_sonoma:  "490eb5703cd9ada12d432f96729ec206387f4fd9c05a8a5c145baec4af3591aa"
    sha256 cellar: :any_skip_relocation, sonoma:        "c1769c7dec0b97811b586331725c5f889429865e93058ca5b20c6b3387cb3008"
    sha256                               arm64_linux:   "9f054d7368eaf07fe8ed1a4875b34e8b30559e1511b24a446f3a9a881f11f136"
    sha256                               x86_64_linux:  "ebe6ef14ee4f6d0aedd20e154f06b160706aa1a925c322fa99b611f4465542e3"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80600", "80700"
    inreplace "src/profiler/profiler.c", \
              "ZSTR_INIT_LITERAL(tmp_name, false)", \
              "zend_string_init(tmp_name, strlen(tmp_name), false)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
