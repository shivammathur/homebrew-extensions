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
  revision 2
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_golden_gate: "4a794cfc9d8eaef6f6b867059778bd09bfaf6d3a79d2ac258a67ab6bf6f79a74"
    sha256 arm64_tahoe:       "548478ed199af106853249fb4ccdb5f58c1bc181792ee1b0b990a09b7806375e"
    sha256 arm64_sequoia:     "8467c13487505a58abf24bbd28bab6a354f00e72f2bcfd3dee3ebe4c15b72d59"
    sha256 arm64_linux:       "5636778244762cc78957231986f5317dc414acb8eaab03a320150c3b6cf5aca1"
    sha256 x86_64_linux:      "6e61a13c76db056ec3a64aca6fdea2fe7b722f28ff88d250d88879fe520219c1"
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
