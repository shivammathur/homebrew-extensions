# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.0.tar.gz"
  sha256 "b10d27bc09f242004474f4cdb3736a27b0dae3f41a9bc92259493fc019f97d10"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "71cc56db45e62ca2543a711080f5b21debf4850cb32be01ba8bd9c4b49a913af"
    sha256                               arm64_sequoia: "1cdd5691a9f4efa2b728a2fa3a8d59ce8a1a00083050f945453d1a990e1587e5"
    sha256                               arm64_sonoma:  "6387e3bd5d0e238e6351e757167742b2e50c7bc32d10091e1630be08ab112332"
    sha256 cellar: :any_skip_relocation, sonoma:        "0f4ad790f88ed81a2f3654974815daf61ddc3b2e41c962e5828a94665769714d"
    sha256                               arm64_linux:   "7c2b4af08ca7ba1352234a9e9287f3da24e65630c1a2ff5e93bb1d7b81c785b8"
    sha256                               x86_64_linux:  "5832239b7d79a9c05825ea64217b93df854955c9aa6664df871fccaf7e0c9edc"
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
