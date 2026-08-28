# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.1.tgz"
  sha256 "cb06519b1382f57ba6f5358504cb37e933d5a5892553300877fd4f3b04cf0560"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fd7982536bf0c391b101b4447614cbd87914f9dfd36f0a93ccc5ce52369a6166"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "83f07de04cabf5653b406fd34eeb44aaf59b912956abc32d6a780b4fbde252b3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3a067166affe6861b80bc2144efaf88b6624d9d15e1a8b6913bfad3d805fb721"
    sha256 cellar: :any_skip_relocation, sonoma:        "95edaad8498d3de80e5c075c2554fe15e0deaaed7abc45d94fda508224409b73"
    sha256 cellar: :any,                 arm64_linux:   "04a68932fc05e3aad13980eebe90bfd4cac8d6f8da3b792b57530096cd72627b"
    sha256 cellar: :any,                 x86_64_linux:  "8eb7383e8af17407fcebd98069745f5b3a0a66c731fe0ceaaddf989fc16fc091"
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
