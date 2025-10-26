# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b2aa123b0a3dab174a90abd0b2db1275ee6afbf1a0b6a1b66c28c8ef37d16a8e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0b27bacffd690bb4e9a1b129d77b3ff2eac8468b419914a183f9ca9bf1a129a7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "29e68fb2b979e277732175c67d80312c64d4ea1f3a8847827e051be4f22a834d"
    sha256 cellar: :any_skip_relocation, sonoma:        "1e0d5ab3a939d86f5ae1707df1020420ec26df1cd0997030926fba1d43ff933a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "80f14a56450f647f444528354f06711c82d9969ea8fedc919cf73780e223a99a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58465ca847ff3035d07602c9bcb1e310af54323045a971d65f71fb8757f51d5a"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
