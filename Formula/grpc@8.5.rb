# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.73.0.tgz"
  sha256 "63959dc527c60cdb056842c5e5ebb45b507452bb121653604ed94c1c23972c7d"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "438d43487a877e318df6f84599481318cad5d5d624ef53f0d8272f02925cb85d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4fc68858db28869781dabeae178d3036ba1e60ecad508fc391aecd3d1e2de0d0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e294a2c0453826f0d02bc27e88cbb97b5c35cd37a47ccdbc61d425366f97be8f"
    sha256 cellar: :any_skip_relocation, ventura:       "e97ff1129393597cd67ceaaebed3ab7a36a207fcf0c53209549fff9e0c91ce91"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "78681ce978e87409b7bc77106a78b1607f22f184849bc536ef8d652be2f1a558"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "efed0e4a43614a4cef8679ee019241fa79deda09b2b8ea2b6519150b3e1a0136"
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
