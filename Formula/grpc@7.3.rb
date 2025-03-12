# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.71.0.tgz"
  sha256 "da142bcf578ec9ce5340fdfaf92633f6589b89885bbf77c5910fd89e244aa4c2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5c4da9c5f6a7bce7d0efabf9013bcf10d453c06323e9561aeb3a65b861e7ae71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "76809860caa634d2bfaa855ac3f8d9ed202b37680e482399ae7da3d14a930b7e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c5b64a174d95bcec12afd50cebac778f32fea83915a110fd3f3cdabd11d76f40"
    sha256 cellar: :any_skip_relocation, ventura:       "b83525fb20abeb96d8bd2ca40dafc7a35403edef364a5b09d859b166478a389c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a924c8c3187d260135e42b2630f93a198bd5f18607e2132ff31c11b9bec7c86"
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
