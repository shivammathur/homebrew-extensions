# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.63.0.tgz"
  sha256 "0d67d0935f1e4a1feabf96a64f24e32af1918cd09ea7bef89211520f938007ca"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "185858cae65c98e4dd81a9a163ffaceb25b5f35b0c001666cfa07908bae658ae"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bc1fc29a8106489a221c7ea121d1e0d00a5518a047126ae8ad8f1d77134faaa5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "555be5b0e5ce71ff31b9891621c69e9e062e2462b7e57ca189b97ea2e35acade"
    sha256 cellar: :any_skip_relocation, ventura:        "afeb4b9066aff00c9a602c8eb62e445e579560af0ae3f32afbc0178066dbe76e"
    sha256 cellar: :any_skip_relocation, monterey:       "2c5eef06684408f385983cfcc422158d1dbbd744b2487a217131d4d9e0228b67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9d29b9f97f603136cbede033db2df02339f0c83653ed08845689a800e911e646"
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
