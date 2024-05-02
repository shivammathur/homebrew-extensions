# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.63.0.tgz"
  sha256 "0d67d0935f1e4a1feabf96a64f24e32af1918cd09ea7bef89211520f938007ca"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ca34b00e94e0a9ca56d030fff260b706a0a36075ea64875ce6e203cd609d7f90"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b9d8ab351cc53913230a895f549f144e693ea9b6f3a6e1205e653cc8eba27b65"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "095d822a21f8994b95e5c41711ca571801dd8e5dc0b00f1362f8c33924284316"
    sha256 cellar: :any_skip_relocation, ventura:        "0dfad2298be4bc0bd773774c9f5a5b7fbcb7c96250215bb3b3d359d425948f6b"
    sha256 cellar: :any_skip_relocation, monterey:       "01c2dbccdf5cbe1b2fbd04381db3e54f822f6cf66a27568c69502e9c1ee9a81a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e1646f9ea0aab28279b59de28a2141dcbe94b335f56ac11faa52c7e342a474ab"
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
