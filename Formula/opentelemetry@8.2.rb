# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT82 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.4.1.tgz"
  sha256 "981edebd3d01b942a7863af097316d725922467699b16d0a70ccf56f37c14a04"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6a55f03d8db269e9887c158f15b9300ec2f655c0c7fd5968c130533fe8103b87"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0c79b53616e14b2971f78ac1ecb9086510315025f0f8bcce6e72150c15a25125"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ee7498efb9b44336cc8fb6a5a25fcd8eea7f2ec53f34575e8cd5b370a058818d"
    sha256 cellar: :any,                 arm64_linux:   "33313f58fb4c6faec474ccf0b370f7ea7f9d714004ce7498dc2fd600eb107a56"
    sha256 cellar: :any,                 x86_64_linux:  "0c4acef0f70d50e324898065bd35f1f2b5c7eb341c011eed84ea8e6afa2b5d02"
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
