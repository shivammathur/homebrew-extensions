# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.75.0.tgz"
  sha256 "d2fa2d09bb12472fd716db1f6d637375e02dfa2b6923d7812ff52554ce365ba1"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d3e04f45762ca1b2f429bc362560b24cd13f8fad3e7a4ae2b72e6b15e352306e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2016523fac46f7b53f952addc97e4f63c90857a6180bd329ad9d68374d3eba96"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "24065fc9231b5aa6c0d1b1289c9c00e8dd013f17ad004113b4b135c254ad5265"
    sha256 cellar: :any_skip_relocation, ventura:       "fbab003dcdc3635d92ec9cc02b61aa1dd780567756cca4e424fef60fb9b7e2a1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4bb75446230a0f5e33700a40adbe06cae0bf5a66e5ce03d274763e386ed70244"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a67e655efc25d2495acf0c889a36e19c10bd0858b43d2f74b6fc892ad255cb93"
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
