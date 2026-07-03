# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4cd26819a9156cc0503ad29b56f14b2f9114e108fc9ba9229f5e002aaef1ff4e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1840178ae6a51c212fb7aa69008c22c1696544348cfe02d42d6d7dcff74a21af"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "daef7225aeef61ac5c7191f355800d5e568c9e260e8098f1654416a34b2d8d60"
    sha256 cellar: :any_skip_relocation, sonoma:        "09fbee1bce977c458ce2b07cd636823f6dc029ff9a3d136a8ac8efd15feee361"
    sha256 cellar: :any,                 arm64_linux:   "776e002932fd5a44dee8c441429c157363049a0eb14cf34129544ac09235567b"
    sha256 cellar: :any,                 x86_64_linux:  "d07a224ee517d9a9f6d50b22318f677ada7a4af5ccb36ab49de09fb24d7af2e1"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
