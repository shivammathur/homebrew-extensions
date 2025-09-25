# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT85 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.0.tgz"
  sha256 "50cd327c7494b5f436631434c8a5f0554aec129e6d499ba61359131ebf1b6757"
  revision 1
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b434fa2e23cfaf12a6e0ffc220baa970104c2d76b05ec3edc7860e36401e79c4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c668ffdfe881f49096fa1cc7ef24efcf82fd37c2ae32d387a384e8ed6faaed1b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "89b30511fab5f98213670b3189e7953ddc06312b33a811a2f302f7c3c347c34d"
    sha256 cellar: :any_skip_relocation, sonoma:        "6963710b48d5279a67dc89745b24e207acf1fda146f36fb9db8c3b3513d10111"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b59cd4ae0b9c388cf971edf4a8bab7f6685ab6ab50c87c772f3653b36645614b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa7bc576f4abe29585cd9075be4d9cde9ebfff2807156c2b68d9eb489405e463"
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
