# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT82 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.0.tgz"
  sha256 "50cd327c7494b5f436631434c8a5f0554aec129e6d499ba61359131ebf1b6757"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dbf423f640b6b5ace6d0122fe66cf0989273d5ebf0544c454254586fadcbea49"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4c92d960ccc908b315291040347d7334a9b0857f00ea0a3ab59bceb86df8f55d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "03690a893e5fb4e9d088af6d58b12cf7a29e0a9f7d64ea5a06c9a8c3f583bb5c"
    sha256 cellar: :any_skip_relocation, ventura:       "626d4b7cb14198a11aad08181ea1bbe230d80bbfffb6279fb34be047a672a3d1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b4f4cd6a23c620835a05023f98f15c348705130480922f96b3e7b1b174e17305"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b65a7daf7048309ac2a9f3f919fc4097436e85f4682efd4dc50cb6949aede1a"
  end

  def install
    Dir.chdir "opentelemetry-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
