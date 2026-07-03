# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.82.0.tgz"
  sha256 "bbcb83e229b565feac351bd88bd80091c4ef613357122fccf8a9930cd988d6ca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9aee99977bac0a631102166d2e51fe72a5dbcbcbcde9ede0ca9ea359e6d180df"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "da57d04d72630f00832b608098abf18fde66a808fcb75c9662b8e93557e057e0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "51ca574ffc1618cfe312786ed2b17a58c7303c6cebcb8c12d1a930c54c19248f"
    sha256 cellar: :any_skip_relocation, sonoma:        "3c52d1a359b282067b9ab2ae988f88f50f88105aeb34e4d325b1ab84eff2dbf2"
    sha256 cellar: :any,                 arm64_linux:   "2fcc0513b8caef7b58c8e0d44a0878fb24ac60695db6635acbe245c7316afc0c"
    sha256 cellar: :any,                 x86_64_linux:  "fc7072ca2c5ca9eeb5bfc67a1a7325e790e5d58052434e0671ae4e90a981b608"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
