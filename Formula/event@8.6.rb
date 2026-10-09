# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT86 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  revision 2
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "b6d5153439013c23cb7e56f2e15485308ba7fa4613969cd9bf80279b4d32ec14"
    sha256 cellar: :any, arm64_tahoe:       "0ddbb27416b60cd1dca6be08d97bbf4aed7bcf1bed92bf74959d995130c52238"
    sha256 cellar: :any, arm64_sequoia:     "6e95f233c528472b5c0397e9d3e0670aa050d21e7b6ad9c418cd4f2d940e5e86"
    sha256 cellar: :any, arm64_linux:       "6275ab98a82bd6b37810b19ceb9dcacf7c22cdecac82f58e218e4ce88e789edc"
    sha256 cellar: :any, x86_64_linux:      "649636268b01e822fecedf641ac868566188ac4fe44b94fff2b84adc137e85c8"
  end

  depends_on "libevent"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
      --with-event-libevent-dir=#{Utils::Path.formula_opt_prefix("libevent")}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
