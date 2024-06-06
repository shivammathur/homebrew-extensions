# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.64.1.tgz"
  sha256 "7eedbce54e29281d8fb97b0924e34d6cb315c5ba12e8a55706ccdde977497d43"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "bcbe41f1ae99dc9a8aa6db4e8347af7250a937c860e511b0281127e8c9173833"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e21d85c7ababf7cf6fa5cfd12f151c84234714e9472f4524765fd0898bcd119b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1b3547780c84c8d0c4a6054399d9b5805f940cf85d48db681b296e450e3d9b04"
    sha256 cellar: :any_skip_relocation, ventura:        "12261e7fc17d037e15509847fa8f13572877f5116c0fbe4a46da0e65532f35e3"
    sha256 cellar: :any_skip_relocation, monterey:       "38ee6d4a60f86313a4bb1c99b76693749368ff736ed697499abee4eec8e1878d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9de542a4f8aa6c565ff430669a2f09f7c98d0ab6750695245d44a925cd4b4eeb"
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
