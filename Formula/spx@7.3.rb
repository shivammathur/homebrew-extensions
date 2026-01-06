# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT73 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.22.tar.gz"
  sha256 "6f89addd100d3d71168c094612eb8e1c06fd8062da6ee4d9df5b31bdfc4de160"
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "81a2decc972adb15e81b7ca7fe340296455ab8686568d30e84900cbfcb72e9ac"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "72fbf937f3bc0bb302bb650ddb2f4b8c14e866035ef5aeee5a530ad3b0d24bc4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7909479232fdbd4bed1ceba4a1a98205f422e89864d5ed54473ea39e6164a664"
    sha256 cellar: :any_skip_relocation, sonoma:        "28e85280e65f9da832c8a9e09c96dc6da53802f19221b06bd18c387b4922d834"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cc014f52739599b629f0cf062d6d03866bdd0cb3a93c37b20cc075e4455f3cf5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f4acef7df9f2f30ee6be3cf84f097fe678f62dfc41e8f728850666a301e4f7d"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
      --with-spx-assets-dir=#{pkgshare}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    system "make", "install-spx-ui-assets"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
