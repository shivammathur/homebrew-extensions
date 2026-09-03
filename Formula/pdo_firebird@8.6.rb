# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ce7896d514b415922b344f58f45471c01de6d4a3.tar.gz?commit=ce7896d514b415922b344f58f45471c01de6d4a3"
  version "8.6.0"
  sha256 "8c6e7f7e79cb7093a4d2873ae9bfdd92735ce1c17dd0ea570fc22d8100e3f838"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any, arm64_tahoe:   "fd4563682fcd791650d83d5b39367d0b6d41121232161532fcfc991f731ef30d"
    sha256 cellar: :any, arm64_sequoia: "ef645edab6f33ea5d14cb7edaf2e0c7eb532b27ea48b2ab92871786379f4cf6d"
    sha256 cellar: :any, arm64_sonoma:  "f067a4e270f3363d5bc72a107dd8045c64304b23c8e78deaff9d9956fe59fc84"
    sha256 cellar: :any, arm64_linux:   "8f81dcfdf7000cbf12b1f99c6ede4faf7933f622b3a0215c94cb1357725c1081"
    sha256 cellar: :any, x86_64_linux:  "cb4ad095a1efee1fafb1b1165041a6035a238594aa5d3e9ed9861d30e5f1f7e1"
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
