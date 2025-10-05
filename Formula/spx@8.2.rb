# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1529469c38b3fe8c0d8a7572fb7ed40120576fab707b43b24ab9555c8074a387"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e9c084327b812f96e46f08309b241e8baa5e24d55634192c442cafb7e6358164"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6c8c9721c33e8680344895d9f4747059353f2283343113f558a70902b6def7d6"
    sha256 cellar: :any_skip_relocation, sonoma:        "93da923f559a790c10789a4ce0a82b70996b3cf2709f8b55be527310fb0b4437"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "90e27eb6655816d29227a43efe3ab34325d1d64fdb3ba78fd505f5fc2525637e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "88194b4be35b6df0fc0c48747b8ca66b51d8d3a7428cd6125370b3a75ebd4254"
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
