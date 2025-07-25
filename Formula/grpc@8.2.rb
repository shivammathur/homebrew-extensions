# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.74.0.tgz"
  sha256 "972ce8a989f2c15a951444950c1febe84eb88e59aeaca29d96e005fe55df1fc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a85aacac5aa9d08fcb6b41c47c697d2e8c3c7b1332294faa125c40e27f4babbe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7ea02c759e48a7480bc6c55ec9a823389bd5cdd01a5d4c3a051c87e8ba7a97d0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9034c8543d7f7d59b7e98e176821a304fbee85c112c95366220f9f9fc52f1c79"
    sha256 cellar: :any_skip_relocation, ventura:       "17e6b9134309d24fa60a1a8f7977fc7c9cb167affeb14e380dcb2c5e73826802"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "de2225254a003db0019e88de27057d2389567c326b76dee54a4c25b0d62c7aa3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "362d691cac5d6acbaac1f54205c1a3b3c8c3ea2387aca9042006b1724166100d"
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
