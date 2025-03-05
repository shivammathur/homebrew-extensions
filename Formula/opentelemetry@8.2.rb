# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT82 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.0.0.tgz"
  sha256 "c986887f3d97568e9457cdeae41f4b4c1ed92b340b7533ecf65945eb7e291f74"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "c3fbf0ce375994f0b858e16359dc4cb8f2b06b23a4055b37c71004d55f6a62e4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "14a3cf18c9449bb11c26876ed79b6eb816559c637a576fc010fff2775db5c254"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4de59359fbedeaec121ac80d67b5197735c5a479e4bd57052463e224666f3e78"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "668df3bed3bfcf73224dc38f5c3d0e8282f9d5f209dba90401980c5f0fca4e33"
    sha256 cellar: :any_skip_relocation, ventura:        "0e94cd5a5d5fdb7cab86a486cc11ea008f0fa2c1cdbb8da8a8b540e1bb561a15"
    sha256 cellar: :any_skip_relocation, monterey:       "213c850daef19d6c450c7375ca66cda6a970b1e0d7e1bcf5318474cce8e72675"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c45d1e4ed5f6fb27f4fbdc61e4212f33bbf10bbdbd5251f0276c4d979b6e2d4c"
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
