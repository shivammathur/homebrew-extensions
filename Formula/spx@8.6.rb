# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT86 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.20.tar.gz"
  sha256 "8de7f8e6137667dbe7e92ba552ccb3b3b3745664efb9af88ece8bda0f58fc94f"
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0c92d6c9b98a35421d62b26d369adb4ca365b8358404215a5b27467a02078681"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a23a96f7e3d77fb989e33649d7f090b54f74c12235f4c740fc1b51ec0b9be027"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4c3c5522e1a01de7bd6daf15dd1ef5a53673a4a8c95768ea349451e1c4122564"
    sha256 cellar: :any_skip_relocation, sonoma:        "819398e22f2f43aa4da8b66f869eeb09050faca3367bbdf333a1b4f28b2491b4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4a714c2aedaee36430d0860ae72fa3a680d45644d011f7d578c90773c3811b15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "893e7d6efc8395ca6ca30b6359bbe193b4dc5182e49047ba3466aaaa4032329e"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    inreplace "src/php_spx.h", /ZEND_MODULE_API_NO.*/, "0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
