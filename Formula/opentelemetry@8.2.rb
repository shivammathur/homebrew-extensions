# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT82 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.1.tgz"
  sha256 "de8315ed3299536f327360a37f03618ab8684c02fbf8dfd8f489c025d88a6498"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "58612369d8b2979a83f469ca0836954d1c0b4173a9de7890f6d51ff39bd51626"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a1d954a4fb111a7d766ab088583ef49d074bc1e4819d5bfc61a5215a6d891543"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "27867cfc0ec3d9f4ae5a92d6dd3d000377911e904b7bfe75af00c8f09bedd6c0"
    sha256 cellar: :any_skip_relocation, sonoma:        "4567bb41c5b06231ee7253b89a54acdc9aa5ce92f18fcd9468e719092ec5474c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8180a1db11d2c6856c3dc7f7455aa225a507f684ff4953c35f0131d9f7114d18"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7dbf0ac916b596ab5169bf24fc77eba0708010f97c117ef6bbf020a5a8fe93d2"
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
