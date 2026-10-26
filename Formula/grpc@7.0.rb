# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "28413d2120611b3c9622f193a08d8657c27f2b35d56257c657ff82604443180c"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "9a684e58b3d335a15c2a4726c7321bb954d945c65ba912f82aefb2ef1681642a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "cda511f006e61ebd9a40a2e377b0793b41a6d53d9c0f7f99e2bec36ff33a5ccf"
    sha256 cellar: :any,                 arm64_linux:       "fe557d978b50a40befd131fda09e074fb36ea839b43f44eb9dcc2a2abfc2676a"
    sha256 cellar: :any,                 x86_64_linux:      "c7a702ec88e8275e805939ea998becc152d090f71eb70cb30a9769ae5573b792"
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
