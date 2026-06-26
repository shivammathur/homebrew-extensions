# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a07653a6a1f2cd703536b5156847c2f8df9c80324bf6ee394c377e83ac1c0b3e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8036bfb5decbd5a2c28cf84f753fc3fa2b545d4a131874bc61590a344f330f6e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9683e1a684fe92d3fad1ec840e5394b765a2691c8b2c8dbeae9a7a48f11e53ef"
    sha256 cellar: :any_skip_relocation, sonoma:        "7eae7d0ccc2cc932453a281c3f4049bcd68f8f60c7067a3e1f8016ca6e6edd97"
    sha256 cellar: :any,                 arm64_linux:   "3cde048a49c234c2d50635464995788b65c360dc7ca4105f9c3507adaf6b8e3c"
    sha256 cellar: :any,                 x86_64_linux:  "b404369a109529de845551bcd28eb32cfef9617e004c66be2d5eb35605b44084"
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
