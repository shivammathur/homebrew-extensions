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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e38451e327c8a0a333a67515697ad4c419d95e900cde391abf62711cb861c578"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9191084ba5904db8dfb3887eaa0bde851f772e02e3a90cee6c3e874bab8ec353"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "413b335f599208c71676028cb6ee9faebadf86ae792464b18447034adc529da3"
    sha256 cellar: :any_skip_relocation, ventura:       "c6a267ec22644966d12da570fc27644f10adf6c07c610badd6fd56666b0dec9b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "60bff95123e1a35115592b3e5f596b78e20d218412baeb94ee64210e6089f4fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "673af68abd2aa64296061be362186daa7454500c983c875300ed549ea9a0f017"
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
