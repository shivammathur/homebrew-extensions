# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/85f513aca01e2edb9b854b6c1bb0f550e62f887b.tar.gz"
  sha256 "9d42780a3a02247cda88bc7cedb0ae8d88a81d44aed96cb21f199916c526aea1"
  version "3.5.0"
  revision 3
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "9a4ffeab15514bb71c54bd9f4cff8cf9f0fb20389c17b82f21f5a281bbce3bc7"
    sha256 arm64_tahoe:       "39b8f3b17777f3469f5d11d09a7a393dd9f4dc55cfc3a33a77cca81304c6f8c0"
    sha256 arm64_sequoia:     "c504176c2a3d08f3c60d38e8f775650de146ccef098ea2728eaec69d0d40608b"
    sha256 arm64_linux:       "899521eca965e76267aaf9842c5615608f48c16e916a41eb7bb7dab90cf1462e"
    sha256 x86_64_linux:      "66d2ae0dca67821f704b276a720f2e40d762a825867a7bbbb00d44ac7b8bcb13"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
