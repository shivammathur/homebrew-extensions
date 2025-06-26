# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/4b28be16e41c34b34aa3a97924fbea815e9a60af.tar.gz"
  sha256 "4a5603709ed983948aefd424a0b0e18285d477b22bb867970e1be3856bbd4549"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 arm64_sequoia: "a2f91323a2e976a55c1c95fbbf4e37fc4327f9de95a4b932bedc630d479f656f"
    sha256 arm64_sonoma:  "04901dc02176968eaf2b422e1d09c1c17e24eb7844dd66dddb145dafabb42e39"
    sha256 arm64_ventura: "60bde673944c3b252d791d058eded75cb47818e6a1830e30cf2939a88a421c38"
    sha256 ventura:       "e4a27dbec9c62c21c28ff26324111eb29c2c7739d7b18bf36aff685737ba3305"
    sha256 arm64_linux:   "fb726974f0b5adaf81ef67719ffede2c333133fc77d813372253a62168d0a240"
    sha256 x86_64_linux:  "3b78a7f94a88020f5bae3a67f476a04d80314d0445d479fff1f7904a3f9350a3"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
