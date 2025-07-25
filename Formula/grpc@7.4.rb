# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4e1e69f0a0917528819af0a41e9e916837aac37cf8e28862011f2c999c44261a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "29c9b837f67834c6b4695bcf273c5da6d87bc585d93315b63eacb00b07bff762"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9d667bc99b114bde04cf35e707d7ad2cc13ed18948d63f8a4b3962499b344e88"
    sha256 cellar: :any_skip_relocation, ventura:       "227262279fc05b54c6bf8d7e9c3bae7aa34c6fb84b36cf318eb82279637d91f5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "643c907d7c23513b3b29b9c016fb1e58d79db8004399539baffab07f4ca93b7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c86b4a223d4594a09aae916876c0fcd41ef9fcd4c54988cff96d01cc53ce13eb"
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
