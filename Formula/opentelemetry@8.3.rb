# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT83 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.1.2.tgz"
  sha256 "43000b9b95d1c10a072a4dce631628dbd8e48af5cac6cd6cbe3b0649ed5fd2d6"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "2c0b50eb74b337cafddb518cbd6f039fb54c933e872d8a0dbb90c9ef055c6c0a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "36e4f4694b8c22494c2f6d69f475271ea04b38afdaa470bafeeae91e79e16338"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "351971ab6716d79ada174b20758ca64a4a2245fe16fc89d9db855935508f3191"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "54233df325c8d12ef0229524cd8e324c372da80362fa6629d91af03fe38e4d2b"
    sha256 cellar: :any_skip_relocation, ventura:        "29762cf68040db2a86c940a8885c3822e5b636165c4e7cdd4327f83d9cc717a2"
    sha256 cellar: :any_skip_relocation, monterey:       "f38d40aefa6d9c62c347926e7e2b1d06bf4797ccdcc5245dd474a1acc1a8a4e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "23f3fc94f958d6084abe6c38b62838c9ad50e7f639f9a79e2226a87d8c47c001"
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
