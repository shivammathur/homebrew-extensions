# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT82 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "f8c702170e1f1deb9716e4fb86f69d9c07e3d73958ae2d79544a234443ade651"
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "55de48af6405e61af73e80d7c65a574812335b82108efa559fd508d79f5d36e9"
    sha256               arm64_golden_gate: "0d52c857f66689170c4037281a37a49afefe496cbf63046cd1eb24ea6dbb7343"
    sha256               arm64_tahoe:       "f26513f852d577073e8dd56b493eebdf4f668d458eb4c55c529da2ea617bc27f"
    sha256               arm64_sequoia:     "627e6e2f9b95f9fe360c5ecb24aafe3df2af9eb90617bc7ac84c4f916daec5f2"
    sha256 cellar: :any, arm64_linux:       "82642d9e84e0dc1e270f570b6f551896d38f11330b9f22435e22197b2b9b1e00"
    sha256 cellar: :any, x86_64_linux:      "56aee95452d8f15c461727224732094da43287fbad70f975c8201a56f8033f6f"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.2", because: "both provide swoole-like coroutine functionality"

  def install
    args = %w[
      --enable-swow
      --enable-swow-ssl
      --enable-swow-curl
      --enable-swow-pdo-pgsql
    ]
    Dir.chdir "ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
