# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.0.tgz"
  sha256 "adaf30db949767bf0ff5a5308638e4b9bb5f711733204ed5a5e8f3014d80a174"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f275b5f246c5ed4f85ccbc657e6146b68e48b47a26fe55b5693bc167e23ab552"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "85a7e44d4bbbd2d4f887c59e3f0029082f3698b6b520eda2376ce4b776ad9af1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "5a8f7af9d5ff2db38e8cac2762676ee6cfb79183d5112266df023ec4d1b67e2e"
    sha256 cellar: :any,                 arm64_linux:       "15c3316b42e85f9f5be86d59794e40c89b227dc234240fc37ca92387e8c62fd7"
    sha256 cellar: :any,                 x86_64_linux:      "043ef00157de47d70a368f456982413937df3bd647e37e360e11a34791810fac"
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
