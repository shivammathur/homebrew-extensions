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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "e96dd765a15376e160105f9f85c0a227cdc306dbf88348ab7646ff468c477625"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f6a955c0c10d44cc5a966968ed01ceb9e94fc6b6c26fe66f0bd61bbcfc287059"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "dfb33f0e7a851f7224c5b823bd32dbf1c3dda2cf3b48abfc90fc8433eb512e9d"
    sha256 cellar: :any,                 arm64_linux:       "17641a4c6f6c8e134e71191476e92a92548bc050a1ff5e56257198eba43cc789"
    sha256 cellar: :any,                 x86_64_linux:      "750ba7cc34c1854a57720f7e2e223a3e864c2c65f937fa76a9d65733b4922092"
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
