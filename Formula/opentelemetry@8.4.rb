# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "717874b032f35f247380e5b16f8e99be3759f4946d2d64433f40c614864675e4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "66cde66d05009da67fe0c760260f835c8d5cc637b3c5acd618c23f70bdfdc908"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d658a9ca78a056e033201abd8c632c5e3890aa6be286127071c4158a4fe1a985"
    sha256 cellar: :any,                 arm64_linux:   "4147d2cda2ce70a42e9a1cc3a7b423c81a7c59745d4731fa090fa81d1411c341"
    sha256 cellar: :any,                 x86_64_linux:  "2e6333783227e20a8c22a10046194071758ddcec53723f3d8ea54e87b28401c6"
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
