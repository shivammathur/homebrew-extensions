# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.75.0.tgz"
  sha256 "d2fa2d09bb12472fd716db1f6d637375e02dfa2b6923d7812ff52554ce365ba1"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e3e2f28b782effcab20c08302135444e3c60cc3464eb2f0f6347b1378888b48"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7fcd0ba4d1ca1637c5ab08381b7a1485de8c6bfd4bb549fd0b339d5ade34ba93"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "608ccfe74beae5aefaf703d82d4a202d13fc6f1595343c89429f4bf11b8e7d45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef0aead56c7bf638a2c560afbc20dfde9b33396d9de55ef11eb3bc19459507b6"
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
