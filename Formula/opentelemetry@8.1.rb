# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT81 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.0.0.tgz"
  sha256 "c986887f3d97568e9457cdeae41f4b4c1ed92b340b7533ecf65945eb7e291f74"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "dc13654f465a8c806b868f8a75a0b6e77e2c29cddba7157659773ff9296664f9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "afb5edfd7ee380ca7a661bfd03c7fa897aafced5486245ce24b98fd7741a755c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "626ad59e90e31c154cbe350149fb16d794c279b789997c0998c4cf076093542d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "679c3f2cd71101930a7876876975b66f2aa30cccc16b7ab35b42d520ad09c2b7"
    sha256 cellar: :any_skip_relocation, ventura:        "08095fb337b3a4c4dbd892543c60189e4758730c4f503017526616e5b04153b7"
    sha256 cellar: :any_skip_relocation, monterey:       "b0101cf6473974a8c5e3932994162df26af526dac8beac33caaf09c2952c4c57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bfb82944fbbe0fbd0be0932ca3c5f82188b21593cac747a8b798dd07c660b174"
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
