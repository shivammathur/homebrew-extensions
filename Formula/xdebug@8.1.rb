# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.3.tar.gz"
  sha256 "954e56021668121ecc50b92d2ad1ce945f22ecf81ffc5bb5835219485b12ef5f"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "82d489ebd940e904a2d540e94c280ee60064e7851e3ce4980a32bb35c5ef5c45"
    sha256                               arm64_sequoia: "65578dff03025f2c12b816aad28c7508611eaad8c30c4f70de7a263f2bf0274b"
    sha256                               arm64_sonoma:  "78531e924acdca0f8b89c9f0059cf37aacd49e3d42e4daf3b78afa9da99d1507"
    sha256 cellar: :any_skip_relocation, sonoma:        "3995225ef848dc149b49be17c86c657e869f28ff4f64d222dabdd516fc022909"
    sha256                               arm64_linux:   "b733a52a5761f8c14e445e46420e053865fa0ef7eba71f53349b94d0c9ce3a1a"
    sha256                               x86_64_linux:  "3203080297607b3a1cfb856cbccb303d6016735aeab90b0d8550347d2fb3f7ac"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
