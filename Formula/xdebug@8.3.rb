# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.6.tar.gz"
  sha256 "4ac1a0032cc2a373e4634ec8123fc6e1648ca615c457164c68c1a8daf47f4bcc"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "cd83c99b1bbe479017501afdcf245679577a021bd4d13ed607ff7c921f05c7eb"
    sha256                               arm64_sequoia: "25055a6424ecb02bbdcf5b865a95452091fdcbac5a37a07ebf1466db7c2da0ed"
    sha256                               arm64_sonoma:  "f8a5f5c4ae94ae5b98029fedb02f5bfcaa6098995fe34d91b96d6d2ec4ebf80c"
    sha256 cellar: :any_skip_relocation, sonoma:        "bfdffb62214205c3311fda81a68a8b3fbc06a8ed4f5310a9260a0a2a6678ec55"
    sha256                               arm64_linux:   "22459454a678387d11de1207f393ad9d88f3353ee4ad1256e60e63830b3ac613"
    sha256                               x86_64_linux:  "431fd82e11735e892dac6788adc7743c871c200487c48d00d043939bb00065d4"
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
