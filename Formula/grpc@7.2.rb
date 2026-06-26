# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8d901c528a5d8b852c3e6886f12b0571be4aa83dc2cb837d9414c4bd61266db3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8f3776c937a2f2580cabcea701a9db39d451316a3909fa0321408a314b3f49e2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d8f6c0646caa91f2239cd1b03c7eec7039d75440499b48273c1a374e1fbc949c"
    sha256 cellar: :any_skip_relocation, sonoma:        "62e242dff42c0f3955372e65ac3c4a1918159af533423c1d2f58b5f3e0ac1fa5"
    sha256 cellar: :any,                 arm64_linux:   "5fc93804c538efedad7a6cf72985027eb64de812dab95f54f3f0562fe680008f"
    sha256 cellar: :any,                 x86_64_linux:  "a07d2302b361c626746c115bf979929cfb86537d0e64490ba2978813e45cc425"
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
