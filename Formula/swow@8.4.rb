# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT84 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "4939bb0390ad95861e7f98c279df41a7a00ca21fc94383be812a5163d63598e7"
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "cbff4a6c46c10ec6781e45a7c505219c939952068e7ae1d12977b66492adadaa"
    sha256                               arm64_sequoia: "efdeabb231ac775c539cf59fab65863f55791e305373e37e710e034bd7e054c3"
    sha256                               arm64_sonoma:  "e2bb43184b85fc9e14a96b1048799393a4fb9679dd93ac25f1621fd552c357c6"
    sha256 cellar: :any,                 sonoma:        "462cf5fbb066bd58468ecdd3dd0502c85e04d0bfe0416ba017ee0ad1a98106c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9b1c49138c1acb72875f9d02c9e8a88990a517f6fb87a30b3b48f1f8ffd5a821"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c115fa17f8eca91bc0864ecd739da4c874c67041df47e268b83b59f4dd5e94c9"
  end

  depends_on "openssl@3"
  depends_on "libpq"

  conflicts_with "swoole@8.4", because: "both provide swoole-like coroutine functionality"

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
